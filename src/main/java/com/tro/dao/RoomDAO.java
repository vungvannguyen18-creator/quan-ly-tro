package com.tro.dao;

import com.tro.entity.Room;
import com.tro.util.JpaUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;
import java.util.List;

public class RoomDAO {

    public void create(Room room) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(room);
            em.getTransaction().commit();
        } catch (Exception e) {
            em.getTransaction().rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    public void update(Room room) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            em.merge(room);
            em.getTransaction().commit();
        } catch (Exception e) {
            em.getTransaction().rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    public Room findById(Long id) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            return em.find(Room.class, id);
        } finally {
            em.close();
        }
    }

    public void delete(Long id) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            Room room = em.find(Room.class, id);
            if (room != null) {
                // Delete child records first to avoid constraint violation
                em.createQuery("DELETE FROM Favorite f WHERE f.room.id = :id").setParameter("id", id).executeUpdate();
                em.createQuery("DELETE FROM Review r WHERE r.room.id = :id").setParameter("id", id).executeUpdate();
                em.createQuery("DELETE FROM Message m WHERE m.conversation.room.id = :id").setParameter("id", id).executeUpdate();
                em.createQuery("DELETE FROM Conversation c WHERE c.room.id = :id").setParameter("id", id).executeUpdate();
                // Then remove the room
                em.remove(room);
            }
            em.getTransaction().commit();
        } catch (Exception e) {
            em.getTransaction().rollback();
            throw new RuntimeException("Không thể xóa phòng vì có dữ liệu giao dịch liên quan (Booking/Payment).", e);
        } finally {
            em.close();
        }
    }

    public List<Room> findAll() {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            String jpql = "SELECT r FROM Room r ORDER BY r.id DESC";
            TypedQuery<Room> query = em.createQuery(jpql, Room.class);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public List<Room> findAllActive() {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            String jpql = "SELECT r FROM Room r WHERE r.status = true ORDER BY r.id DESC";
            TypedQuery<Room> query = em.createQuery(jpql, Room.class);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public List<Room> findByOwnerId(Long ownerId) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            String jpql = "SELECT r FROM Room r WHERE r.owner.id = :ownerId ORDER BY r.id DESC";
            TypedQuery<Room> query = em.createQuery(jpql, Room.class);
            query.setParameter("ownerId", ownerId);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public List<Room> searchRooms(String keyword, Double minPrice, Double maxPrice, String address,
                                  Boolean hasWifi, Boolean hasAirConditioner, Boolean hasParking, String genderAllowed) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            StringBuilder jpql = new StringBuilder("SELECT r FROM Room r WHERE r.status = true");
            if (keyword != null && !keyword.trim().isEmpty()) {
                jpql.append(" AND r.title LIKE :keyword");
            }
            if (minPrice != null) {
                jpql.append(" AND r.price >= :minPrice");
            }
            if (maxPrice != null) {
                jpql.append(" AND r.price <= :maxPrice");
            }
            if (address != null && !address.trim().isEmpty()) {
                jpql.append(" AND r.address LIKE :address");
            }
            if (hasWifi != null && hasWifi) {
                jpql.append(" AND r.hasWifi = true");
            }
            if (hasAirConditioner != null && hasAirConditioner) {
                jpql.append(" AND r.hasAirConditioner = true");
            }
            if (hasParking != null && hasParking) {
                jpql.append(" AND r.hasParking = true");
            }
            if (genderAllowed != null && !genderAllowed.isEmpty() && !genderAllowed.equals("ALL")) {
                jpql.append(" AND (r.genderAllowed = :genderAllowed OR r.genderAllowed = 'ALL')");
            }

            TypedQuery<Room> query = em.createQuery(jpql.toString(), Room.class);

            if (keyword != null && !keyword.trim().isEmpty()) {
                query.setParameter("keyword", "%" + keyword + "%");
            }
            if (minPrice != null) {
                query.setParameter("minPrice", minPrice);
            }
            if (maxPrice != null) {
                query.setParameter("maxPrice", maxPrice);
            }
            if (address != null && !address.trim().isEmpty()) {
                query.setParameter("address", "%" + address + "%");
            }
            if (genderAllowed != null && !genderAllowed.isEmpty() && !genderAllowed.equals("ALL")) {
                query.setParameter("genderAllowed", genderAllowed);
            }

            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public List<Room> getRecommendations(Room currentRoom, int limit) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            // Recommendation logic based on similar category, and price +/- 30%
            String jpql = "SELECT r FROM Room r WHERE r.status = true AND r.id != :currentId " +
                          "AND r.category.id = :categoryId " +
                          "AND r.price BETWEEN :minPrice AND :maxPrice " +
                          "ORDER BY r.id DESC";
                          
            TypedQuery<Room> query = em.createQuery(jpql, Room.class);
            query.setParameter("currentId", currentRoom.getId());
            query.setParameter("categoryId", currentRoom.getCategory().getId());
            
            Double minPrice = currentRoom.getPrice() * 0.7;
            Double maxPrice = currentRoom.getPrice() * 1.3;
            query.setParameter("minPrice", minPrice);
            query.setParameter("maxPrice", maxPrice);
            
            query.setMaxResults(limit);
            
            List<Room> recommendations = query.getResultList();
            
            // Fallback: if not enough recommendations, just get latest active rooms
            if (recommendations.size() < limit) {
                String fallbackJpql = "SELECT r FROM Room r WHERE r.status = true AND r.id != :currentId ORDER BY r.id DESC";
                TypedQuery<Room> fallbackQuery = em.createQuery(fallbackJpql, Room.class);
                fallbackQuery.setParameter("currentId", currentRoom.getId());
                fallbackQuery.setMaxResults(limit - recommendations.size());
                
                List<Room> fallbacks = fallbackQuery.getResultList();
                for (Room r : fallbacks) {
                    if (!recommendations.contains(r)) {
                        recommendations.add(r);
                    }
                }
            }
            
            return recommendations;
        } finally {
            em.close();
        }
    }
}
