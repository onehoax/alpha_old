import { app_user } from '@prisma/client';

export class User implements app_user {
  user_id: number;
  given_names: string;
  last_names: string;
  government_id: string;
  email: string;
  cell_phone_number: string;
  dob: Date;
  created_at: Date;
  updated_at: Date;
}
