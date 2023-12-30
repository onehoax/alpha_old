import {
  IsEmail,
  IsNotEmpty,
  IsString,
  MaxLength,
  MinLength,
} from 'class-validator';

export class CreateUserDto {
  @IsString()
  @IsNotEmpty()
  @MinLength(4)
  @MaxLength(30)
  given_names: string;

  @IsString()
  @IsNotEmpty()
  @MinLength(4)
  @MaxLength(30)
  last_names: string;

  @IsString()
  @IsNotEmpty()
  @MinLength(8)
  @MaxLength(10)
  government_id: string;

  @IsEmail()
  @IsNotEmpty()
  @MinLength(10)
  @MaxLength(50)
  email: string;

  @IsString()
  @IsNotEmpty()
  @MinLength(12)
  @MaxLength(12)
  cell_phone_number: string;

  @IsString()
  @IsNotEmpty()
  @MinLength(10)
  @MaxLength(10)
  dob: Date;
}
