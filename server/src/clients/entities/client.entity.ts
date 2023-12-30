import { client } from '@prisma/client';

export class Client implements client {
  client_id: number;
  is_active: boolean;
  age: number;
  jump_test: number;
  blood_pressure: number;
  triglycerides: number;
  blood_glucose: number;
  cholesterol: number;
  created_at: Date;
  updated_at: Date;
}
