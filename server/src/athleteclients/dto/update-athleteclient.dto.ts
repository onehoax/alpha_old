import { PartialType } from '@nestjs/mapped-types';
import { CreateAthleteclientDto } from './create-athleteclient.dto';

export class UpdateAthleteclientDto extends PartialType(CreateAthleteclientDto) {}
