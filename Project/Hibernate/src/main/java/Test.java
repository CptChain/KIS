import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;

public class Test {
    public static void main(final String[] args) {
        final Country russia = new Country();
        russia.name = "Russia";
        russia.code = "ru";

        final City moscow = new City();
        moscow.country = russia;
        moscow.name = "Moscow";

        final Configuration cfg = new Configuration();
        cfg.configure("hibernate.cfg.xml");
        cfg.setPhysicalNamingStrategy(new OurPhysicalNamingStrategy());
        try (final SessionFactory sf = cfg.buildSessionFactory()) {
            try (final Session session = sf.openSession()) {
                final Transaction t = session.beginTransaction();
                assert t != null;
                try {
                    session.persist(moscow);
                    t.commit();
                } catch (final Exception e) {
                    t.rollback();
                    throw e;
                }
            }
        }
    }
}
