import javax.persistence.*;
import java.time.LocalDateTime;

@Entity
public class Product {
    @Column(name = "ProductID")
    @Id
    int id;

    @Column(name = "Code")
    String code;

    @Column(name = "Name")
    String name;

    @JoinColumn(name = "ProductGroupID")
    @ManyToOne(cascade = {CascadeType.PERSIST})
    Group group;

    @JoinColumn(name = "ProductTypeID")
    @ManyToOne(cascade = {CascadeType.PERSIST})
    Type type;

    @Column(name = "Price")
    int price;

    @Column(name = "Unit")
    String unit;

    @JoinColumn(name = "ProducerID")
    @ManyToOne(cascade = {CascadeType.PERSIST})
    Producer producer;

    @Column(name = "Status")
    String status;

    @Column(name = "Original")
    boolean original;

    @Column(name = "AddTime")
    LocalDateTime addedOn;

    @JoinColumn(name = "CreatorID")
    @ManyToOne(cascade = {CascadeType.PERSIST})
    User creator;

    @Column(name = "Notes")
    String notes;

    @Entity
    public static class Type {
        @Column(name = "ProductTypeID")
        @Id
        int id;

        @Column(name = "ProductType")
        String name;

        @JoinColumn(name = "ProductGroupID")
        @ManyToOne(cascade = {CascadeType.PERSIST})
        Group group;
    }

    @Entity
    public static class Group {
        @Column(name = "ProductGroupID")
        @Id
        int id;

        @Column(name = "ProductGroup")
        String name;
    }
}
