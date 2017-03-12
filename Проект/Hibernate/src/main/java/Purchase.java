import javax.persistence.*;
import java.time.LocalDateTime;
import java.util.List;

@Entity
@Table(name = "Purchases")
public class Purchase {
    @Column(name = "PurchaseID")
    @Id
    int id;

    @Column(name = "PurchaseDate")
    LocalDateTime madeOn;

    @JoinColumn(name = "StoreID")
    @ManyToOne(cascade = {CascadeType.PERSIST})
    Store store;

    @JoinColumn(name = "SupplierID")
    @ManyToOne(cascade = {CascadeType.PERSIST})
    Supplier supplier;

    @Column(name = "Amount")
    int amount;

    @Column(name = "Status")
    String status;

    @Column(name = "ArrivalDate")
    LocalDateTime arrivedOn;

    @OneToMany(mappedBy = "purchase", cascade = {CascadeType.PERSIST})
    List<Product> items;

    @Column(name = "AddTime")
    LocalDateTime addedOn;

    @JoinColumn(name = "CreatorID")
    @ManyToOne(cascade = {CascadeType.PERSIST})
    User creator;

    @Column(name = "Notes")
    String notes;

    @Entity
    @Table(name = "PurchasesProducts")
    public static class Product {
        @Column(name = "PurchasesProductsID")
        @Id
        int id;

        @JoinColumn(name = "PurchaseID")
        @ManyToOne(cascade = {CascadeType.PERSIST})
        Purchase purchase;

        @JoinColumn(name = "ProductID")
        @ManyToOne(cascade = {CascadeType.PERSIST})
        Product product;

        @Column(name = "Quantity")
        float quantity;

        @Column(name = "Price")
        float price;

        @Column(name = "Amount")
        float amount;

        @Column(name = "Party")
        String party;

        @Column(name = "Notes")
        String notes;

        @Column(name = "AddTime")
        LocalDateTime addedOn;
    }
}
