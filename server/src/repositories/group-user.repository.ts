import { Injectable } from '@nestjs/common';
import { Kysely } from 'kysely';
import { InjectKysely } from 'nestjs-kysely';
import { DB } from 'src/schema';

type GroupUser = { groupId: string; userId: string };

@Injectable()
export class GroupUserRepository {
  constructor(@InjectKysely() private db: Kysely<DB>) {}

  getUsers(groupId: string) {
    return this.db.selectFrom('group_user').select(['userId']).where('groupId', '=', groupId).execute();
  }

  async exists({ groupId, userId }: GroupUser) {
    const groupUser = await this.db
      .selectFrom('group_user')
      .select(['userId'])
      .where('groupId', '=', groupId)
      .where('userId', '=', userId)
      .execute();

    return !!groupUser;
  }

  create({ userId, groupId }: GroupUser) {
    return this.db
      .insertInto('group_user')
      .values({ userId, groupId })
      .returning(['userId', 'createdAt', 'updatedAt'])
      .executeTakeFirstOrThrow();
  }

  delete({ userId, groupId }: GroupUser) {
    return this.db.deleteFrom('group_user').where('userId', '=', userId).where('groupId', '=', groupId).execute();
  }
}
