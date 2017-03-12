import javax.persistence.*;
import java.time.LocalDate;
import java.time.LocalDateTime;

@Entity
@Table(name = "Users")
public class User {
    @Column(name = "UserID")
    @Id
    int id;

    @Column(name = "UserName")
    String name;

    @Column(name = "Password")
    String password;

    @JoinColumn(name = "RoleID")
    @ManyToOne(cascade = {CascadeType.PERSIST})
    Role role;

    @Column(name = "BirthDate")
    LocalDate birthDate;

    @Column(name = "Email")
    String email;

    @Column(name = "Title")
    String title;

    @Column(name = "LastLoginTime")
    LocalDateTime lastLoggedInOn;

    @Column(name = "LastLogoutTime")
    LocalDateTime lastLoggedOutOn;

    @Column(name = "Status")
    boolean status;

    @Column(name = "AddTime")
    LocalDateTime addedOn;

    @Column(name = "Notes")
    String notes;

    @Entity
    @Table(name = "UserRoles")
    public static class Role {
        @Column(name = "UserRoleID")
        @Id
        int id;

        @Column(name = "UserRole")
        String name;
    }
}
