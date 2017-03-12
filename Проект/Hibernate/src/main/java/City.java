import javax.persistence.*;

@Entity
@Table(name = "Cities")
public class City {
    @Column(name = "CityID")
    @Id
    int id;

    @Column(name = "City")
    String name;

    @JoinColumn(name = "CountryID")
    @ManyToOne(cascade = {CascadeType.PERSIST})
    Country country;
}
