package com.sistema.controller;

import com.sistema.models.Usuario;
import com.sistema.repositories.UsuarioRepository;
import com.sistema.services.LogService;
import org.springframework.web.bind.annotation.*;

import java.util.Map;
import java.util.UUID;

@RestController
@RequestMapping("/api")
@CrossOrigin(origins = "*")
public class LoginController {

    private final UsuarioRepository usuarioRepo;
    private final LogService logService;

    public LoginController(UsuarioRepository usuarioRepo, LogService logService) {
        this.usuarioRepo = usuarioRepo;
        this.logService = logService;
    }

    @PostMapping("/login")
    public Map<String, String> login(@RequestBody Map<String, String> body) {

        Usuario usuario = usuarioRepo.findByEmail(body.get("email"));

        if (usuario == null || !usuario.getSenha().equals(body.get("senha"))) {
            return Map.of("erro", "Login inválido");
        }

        logService.registrar("LOGIN", usuario.getNome());

        String token = UUID.randomUUID().toString();

        return Map.of("token", token);
    }
}
