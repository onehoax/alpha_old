import { IsNotEmpty, IsString } from 'class-validator';

export class CreateUserroleDto {
  @IsString()
  @IsNotEmpty()
  user_id: string;

  @IsString()
  @IsNotEmpty()
  role_id: string;
}
