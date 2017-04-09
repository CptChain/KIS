import javax.persistence.*;
import java.time.LocalDateTime;
import java.util.List;

@Entity
@Table(name = "Sales")
public class Sale {
    @Column(name = "SaleID")
    @Id
    int id;

    @Column(name = "OrderNumber")
    String orderNo;

    @Column(name = "OrderDate")
    LocalDateTime orderedOn;

    @JoinColumn(name = "ClientID")
    @ManyToOne(cascade = {CascadeType.PERSIST})
    Client client;

    @Column(name = "PayForm")
    String payForm;

    @Column(name = "StoreID")
    @ManyToOne(cascade = {CascadeType.PERSIST})
    Store store;

    @OneToMany(mappedBy = "sale")
    List<Product> items;

    @Column(name = "DoneDate")
    LocalDateTime doneOn;

    @Column(name = "SaleStatus")
    String status;

    @Column(name = "AddTime")
    LocalDateTime addedOn;

    @Column(name = "CreatorID")
    @ManyToOne(cascade = {CascadeType.PERSIST})
    User creator;

    @Column(name = "Notes")
    String notes;

    @Entity
    @Table(name = "SalesProducts")
    public static class Product {
        @Column(name = "SalesProductID")
        @Id
        int id;

        @JoinColumn(name = "SaleID")
        @ManyToOne(cascade = {CascadeType.PERSIST})
        Sale sale;

        @JoinColumn(name = "ProductID")
        @ManyToOne(cascade = {CascadeType.PERSIST})
        Product product;

        @Column(name = "Quantity")
        float quantity;

        @Column(name = "Price")
        int price;

        @Column(name = "Discount")
        float discount;

        @Column(name = "AddTime")
        LocalDateTime addedOn;

        @JoinColumn(name = "CreatorID")
        @ManyToOne(cascade = {CascadeType.PERSIST})
        User creator;

        @Column(name = "Notes")
        String notes;
    }
}
