import { role } from '@prisma/client';

export class Role implements role {
  role_id: number;
  code_name: string;
  ui_name: string;
  created_at: Date;
  updated_at: Date;
}
