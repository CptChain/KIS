import javax.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "Stores")
public class Store {
    @Column(name = "StoreID")
    @Id
    int id;

    @Column(name = "Name")
    String name;

    @Column(name = "Address")
    String address;

    @Column(name = "Phone")
    String phone;

    @Column(name = "Notes")
    String notes;

    @Column(name = "AddTime")
    LocalDateTime addedOn;

    @Column(name = "CreatorID")
    @ManyToOne(cascade = {CascadeType.PERSIST})
    User creator;
}
