import javax.persistence.*;

@Entity
@Table(name = "Cars")
public class Car {
    @Column(name = "CarID")
    @Id
    int id;

    @JoinColumn(name = "ProducerID")
    @ManyToOne(cascade = {CascadeType.PERSIST})
    Producer producer;

    @Column(name = "Model")
    String modelName;

    @Column(name = "ProduceYear")
    int productionYear;

    @Column(name = "Engine")
    String engineModelName;

    @Column(name = "BodyType")
    String bodyTypeName;
}
