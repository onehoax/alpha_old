import { client_injured } from '@prisma/client';

export class Injuredclient implements client_injured {
  client_injured_id: number;
  injury_type: string;
  sport_type: string;
  created_at: Date;
  updated_at: Date;
}
