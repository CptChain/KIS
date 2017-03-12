import javax.persistence.*;

@Entity
@Table(name = "Applicability")
public class Applicability {
    @Column(name = "ApplicabilityID")
    @Id
    int id;

    @JoinColumn(name = "CarID")
    @ManyToOne(cascade = {CascadeType.PERSIST})
    Car car;

    @JoinColumn(name = "ProductID")
    @ManyToOne(cascade = {CascadeType.PERSIST})
    Product product;
}
