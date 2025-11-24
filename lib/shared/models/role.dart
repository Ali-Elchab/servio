enum Role { user, provider, admin }

extension RoleX on Role {
  int get id {
    switch (this) {
      case Role.admin:
        return 1;
      case Role.user:
        return 2;
      case Role.provider:
        return 3;
    }
  }

  static Role? fromId(int? id) {
    switch (id) {
      case 1:
        return Role.admin;
      case 2:
        return Role.user;
      case 3:
        return Role.provider;
      default:
        return null;
    }
  }
}
