import { trainer } from '@prisma/client';

export class Trainer implements trainer {
  trainer_id: number;
  created_at: Date;
  updated_at: Date;
}
