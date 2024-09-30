import { ValidationOptions, ValidatorConstraintInterface } from 'class-validator';
import { UserService } from 'src/user/user.service';
export declare class IsUniqueConstraint implements ValidatorConstraintInterface {
    private readonly userService;
    constructor(userService: UserService);
    validate(value: any): Promise<boolean>;
    defaultMessage(): string;
}
export declare function IsUnique(validationOptions?: ValidationOptions): (object: Object, propertyName: string) => void;
export declare class SignUpDto {
    readonly name: string;
    readonly username: string;
    readonly email: string;
    readonly password: string;
    readonly role: string;
}
