import javax.persistence.*;

@Entity
@Table(name = "Countries")
public class Country {
    @Column(name = "CountryID")
    @Id
    int id;

    @Column(name = "Country")
    String name;

    @Column(name = "CountryCode")
    String code;
}
