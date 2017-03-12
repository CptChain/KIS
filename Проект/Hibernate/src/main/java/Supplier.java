import javax.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "Suppliers")
public class Supplier {
    @Column(name = "SupplierID")
    @Id
    int id;

    @Column(name = "Name")
    String name;

    @Column(name = "LegalForm")
    String legalForm;

    @Column(name = "Bank")
    String bankName;

    @Column(name = "Address")
    String address;

    @Column(name = "CountryID")
    @ManyToOne(cascade = {CascadeType.PERSIST})
    Country country;

    @JoinColumn(name = "CityID")
    @ManyToOne(cascade = {CascadeType.PERSIST})
    City city;

    @Column(name = "Phone")
    String phone;

    @Column(name = "Email")
    String email;

    @Column(name = "Website")
    String website;

    @Column(name = "Notes")
    String notes;

    @Column(name = "Status")
    String status;

    @Column(name = "AddTime")
    LocalDateTime addedOn;

    @JoinColumn(name = "CreatorID")
    @ManyToOne(cascade = {CascadeType.PERSIST})
    User creator;
}
