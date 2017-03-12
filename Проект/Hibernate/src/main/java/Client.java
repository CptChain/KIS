import javax.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "Clients")
public class Client {
    @Column(name = "ClientID")
    @Id
    int id;

    @Column(name = "Name")
    String name;

    @Column(name = "LegalForm")
    String legalForm;

    @Column(name = "Loyalty")
    String loyalty;

    @Column(name = "Address")
    String address;

    @JoinColumn(name = "CityID")
    @ManyToOne(cascade = {CascadeType.PERSIST})
    City city;

    @Column(name = "Phone")
    String phone;

    @Column(name = "Email")
    String email;

    @Column(name = "Status")
    String status;

    @Column(name = "AddTime")
    LocalDateTime addedOn;

    @JoinColumn(name = "CreatorID")
    @ManyToOne(cascade = {CascadeType.PERSIST})
    User creator;

    @Column(name = "Notes")
    String notes;
}
