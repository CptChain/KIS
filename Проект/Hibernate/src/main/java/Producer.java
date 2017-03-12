import javax.persistence.*;

@Entity
@Table(name = "Producers")
public class Producer {
    @Column(name = "ProducerID")
    @Id
    int id;

    @Column(name = "Name")
    String name;

    @Column(name = "Code")
    String code;

    @JoinColumn(name = "CountryID")
    @ManyToOne(cascade = {CascadeType.PERSIST})
    Country country;
}
