import { ArrayNotEmpty } from 'class-validator';
import { ValidateUUID } from 'src/validation';

export class GroupUserCreateAllDto {
  @ArrayNotEmpty()
  users!: GroupUserDto[];
}

export class GroupUserDto {
  @ValidateUUID()
  userId!: string;
}

export class GroupUserResponseDto {
  userId!: string;
  createdAt!: Date;
  updatedAt!: Date;
}

type GroupUser = {
  userId: string;
  createdAt: Date;
  updatedAt: Date;
};

export const mapGroupUserAdmin = (group: GroupUser): GroupUserResponseDto => {
  return {
    userId: group.userId,
    createdAt: group.createdAt,
    updatedAt: group.updatedAt,
  };
};
