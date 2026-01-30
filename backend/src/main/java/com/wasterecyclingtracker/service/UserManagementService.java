package com.wasterecyclingtracker.service;

import com.wasterecyclingtracker.entity.User;
import com.wasterecyclingtracker.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class UserManagementService {

    private final UserRepository userRepository;

    /**
     * Create a new user
     */
    public User createUser(String username, String password, User.UserRole role) {
        // Check if user already exists
        if (userRepository.findByUsername(username).isPresent()) {
            throw new RuntimeException("User already exists: " + username);
        }

        User user = new User();
        user.setUsername(username);
        user.setPassword(password); // In production, should be hashed!
        user.setRole(role);
        return userRepository.save(user);
    }

    /**
     * Get all users
     */
    public List<User> getAllUsers() {
        return userRepository.findAll();
    }

    /**
     * Get user by username
     */
    public Optional<User> getUserByUsername(String username) {
        return userRepository.findByUsername(username);
    }

    /**
     * Get user by ID
     */
    public Optional<User> getUserById(Long id) {
        return userRepository.findById(id);
    }

    /**
     * Update user
     */
    public User updateUser(Long id, String password, User.UserRole role) {
        User user = userRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("User not found with id: " + id));

        if (password != null && !password.isEmpty()) {
            user.setPassword(password);
        }
        if (role != null) {
            user.setRole(role);
        }

        return userRepository.save(user);
    }

    /**
     * Delete user
     */
    public void deleteUser(Long id) {
        if (!userRepository.existsById(id)) {
            throw new RuntimeException("User not found with id: " + id);
        }
        userRepository.deleteById(id);
    }

    /**
     * Get all family users
     */
    public List<User> getFamilyUsers() {
        return userRepository.findAll().stream()
                .filter(u -> u.getRole() == User.UserRole.FAMILY)
                .toList();
    }

    /**
     * Get all center users
     */
    public List<User> getCenterUsers() {
        return userRepository.findAll().stream()
                .filter(u -> u.getRole() == User.UserRole.CENTER)
                .toList();
    }
}
