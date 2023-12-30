import { user_role } from '@prisma/client';

export class Userrole implements user_role {
  user_id: number;
  role_id: number;
  created_at: Date;
  updated_at: Date;
}
