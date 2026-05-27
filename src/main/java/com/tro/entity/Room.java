package com.tro.entity;

import jakarta.persistence.*;
import lombok.Data;

@Data
@Entity
@Table(name = "Rooms")
public class Room {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(columnDefinition = "NVARCHAR(255)")
    private String title;

    private Double price;

    private Double area;
    
    @Column(columnDefinition = "NVARCHAR(MAX)")
    private String address;

    @Column(columnDefinition = "NVARCHAR(MAX)")
    private String description;

    private String image;

    private Boolean status;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "category_id")
    private Category category;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "owner_id")
    private User owner;

    // Phase 4 fields
    private Double latitude;
    private Double longitude;
    
    @Column(name = "has_wifi")
    private Boolean hasWifi = false;
    
    @Column(name = "has_air_conditioner")
    private Boolean hasAirConditioner = false;
    
    @Column(name = "has_washing_machine")
    private Boolean hasWashingMachine = false;
    
    @Column(name = "has_parking")
    private Boolean hasParking = false;
    
    @Column(name = "has_camera")
    private Boolean hasCamera = false;
    
    @Column(name = "has_guard")
    private Boolean hasGuard = false;
    
    @Column(name = "has_mezzanine")
    private Boolean hasMezzanine = false;
    
    @Column(name = "gender_allowed")
    private String genderAllowed = "ALL"; // NAM, NU, ALL
    
    @Column(name = "max_people")
    private Integer maxPeople;
}
