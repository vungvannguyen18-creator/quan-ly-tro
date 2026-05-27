package com.tro.dao;

import com.tro.entity.PaymentTransaction;
import com.tro.util.JpaUtil;
import jakarta.persistence.EntityManager;

public class TransactionDAO {

    public void create(PaymentTransaction transaction) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(transaction);
            em.getTransaction().commit();
        } catch (Exception e) {
            em.getTransaction().rollback();
            throw e;
        } finally {
            em.close();
        }
    }
}
