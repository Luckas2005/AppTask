package com.sistema.models;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "grupos_usuarios")
public class GrupoUsuario {

    @Id
    private String idGrupo;

    private String nomeGrupo;
    private String permissao;

    public GrupoUsuario() {}
}
