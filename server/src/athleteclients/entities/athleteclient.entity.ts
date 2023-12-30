import { client_athlete } from '@prisma/client';

export class Athleteclient implements client_athlete {
  client_athlete_id: number;
  sport: string;
  objective: string;
  created_at: Date;
  updated_at: Date;
}
