import { UpdatedAtTrigger, UpdateIdColumn } from 'src/decorators';
import { group_delete_audit } from 'src/schema/functions';
import {
  AfterDeleteTrigger,
  Column,
  CreateDateColumn,
  Generated,
  Index,
  PrimaryGeneratedColumn,
  Table,
  Timestamp,
  UpdateDateColumn,
} from 'src/sql-tools';

@Table('group')
@UpdatedAtTrigger('group_updatedAt')
@AfterDeleteTrigger({
  scope: 'statement',
  function: group_delete_audit,
  referencingOldTableAs: 'old',
  when: 'pg_trigger_depth() = 0',
})
@Index({ columns: ['updatedAt', 'id'] })
export class GroupTable {
  @PrimaryGeneratedColumn()
  id!: Generated<string>;

  @Column({ unique: true })
  name!: string;

  @Column({ nullable: true })
  description!: string | null;

  @CreateDateColumn()
  createdAt!: Generated<Timestamp>;

  @UpdateDateColumn()
  updatedAt!: Generated<Timestamp>;

  @UpdateIdColumn({ index: true })
  updateId!: Generated<string>;
}
