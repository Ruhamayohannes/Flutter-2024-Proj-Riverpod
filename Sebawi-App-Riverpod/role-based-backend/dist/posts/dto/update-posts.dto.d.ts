import { User } from 'src/user/schemas/user.schema';
export declare class UpdatePostsDto {
    readonly name: string;
    readonly description: string;
    readonly contact: string;
    readonly user: User;
}
