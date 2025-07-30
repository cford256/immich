import { BadRequestException, Injectable } from '@nestjs/common';
import { PostgresError } from 'postgres';
import { AuthDto } from 'src/dtos/auth.dto';
import { GroupUserCreateAllDto, GroupUserResponseDto, mapGroupUserAdmin } from 'src/dtos/group-user.dto';
import {
  GroupAdminCreateDto,
  GroupAdminResponseDto,
  GroupAdminSearchDto,
  GroupAdminUpdateDto,
  mapGroupAdmin,
} from 'src/dtos/group.dto';
import { Permission } from 'src/enum';
import { BaseService } from 'src/services/base.service';

@Injectable()
export class GroupAdminService extends BaseService {
  async search(auth: AuthDto, dto: GroupAdminSearchDto): Promise<GroupAdminResponseDto[]> {
    const groups = await this.groupRepository.search(dto);
    return groups.map((group) => mapGroupAdmin(group));
  }

  async create(auth: AuthDto, dto: GroupAdminCreateDto): Promise<GroupAdminResponseDto> {
    try {
      const { users, ...groupDto } = dto;
      const group = await this.groupRepository.create(groupDto, users);
      return mapGroupAdmin(group);
    } catch (error) {
      this.handleError(error);
    }
  }

  async get(auth: AuthDto, id: string): Promise<GroupAdminResponseDto> {
    const group = await this.findOrFail(id);
    return mapGroupAdmin(group);
  }

  async update(auth: AuthDto, id: string, dto: GroupAdminUpdateDto): Promise<GroupAdminResponseDto> {
    await this.findOrFail(id);
    const updated = await this.groupRepository.update(id, { ...dto, updatedAt: new Date() });
    return mapGroupAdmin(updated);
  }

  async delete(auth: AuthDto, id: string): Promise<void> {
    await this.findOrFail(id);
    await this.groupRepository.delete(id);
  }

  async addUsers(auth: AuthDto, id: string, { users }: GroupUserCreateAllDto): Promise<GroupUserResponseDto[]> {
    await this.requireAccess({ auth, permission: Permission.AdminGroupUserUpdate, ids: [id] });

    const existingUsers = await this.groupUserRepository.getUsers(id);
    const added: GroupUserResponseDto[] = [];

    for (const { userId } of users) {
      const exists = existingUsers.find(({ userId }) => id === userId);
      if (exists) {
        throw new BadRequestException('User already added');
      }

      const user = await this.userRepository.get(userId, {});
      if (!user) {
        throw new BadRequestException('User not found');
      }

      const newUser = await this.groupUserRepository.create({ userId, groupId: id });
      added.push(newUser);
    }

    return added.map((user) => mapGroupUserAdmin(user));
  }

  async removeUser(auth: AuthDto, id: string, userId: string): Promise<void> {
    await this.findOrFail(id);

    const exists = await this.groupUserRepository.exists({ groupId: id, userId });
    if (!exists) {
      throw new BadRequestException('Group does not include this user');
    }

    await this.groupUserRepository.delete({ groupId: id, userId });
  }

  private handleError(error: unknown): never {
    if ((error as PostgresError).constraint_name === 'group_name_uq') {
      throw new BadRequestException('Group with this name already exists');
    }
    throw error;
  }

  private async findOrFail(id: string) {
    const group = await this.groupRepository.get(id);
    if (!group) {
      throw new BadRequestException('Group not found');
    }
    return group;
  }
}
