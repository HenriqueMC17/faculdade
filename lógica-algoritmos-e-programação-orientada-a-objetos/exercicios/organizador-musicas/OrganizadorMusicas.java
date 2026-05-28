package exercicios;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Scanner;

class Musica {
    private String titulo;
    private String artista;
    private String album;
    private int duracaoSegundos;

    public Musica(String titulo, String artista, String album, int duracaoSegundos) {
        if (titulo == null || titulo.trim().isEmpty() || artista == null || artista.trim().isEmpty()) {
            throw new IllegalArgumentException("Título e Artista são campos obrigatórios.");
        }
        if (duracaoSegundos <= 0) {
            throw new IllegalArgumentException("A duração deve ser maior que zero segundos.");
        }
        this.titulo = titulo;
        this.artista = artista;
        this.album = album != null && !album.trim().isEmpty() ? album : "Sem Álbum";
        this.duracaoSegundos = duracaoSegundos;
    }

    public String getTitulo() { return titulo; }
    public String getArtista() { return artista; }
    public String getAlbum() { return album; }
    public int getDuracaoSegundos() { return duracaoSegundos; }

    public String getTempoFormatado() {
        int minutos = duracaoSegundos / 60;
        int segundos = duracaoSegundos % 60;
        return String.format("%d:%02d", minutos, segundos);
    }

    @Override
    public String toString() {
        return String.format("🎵 \"%s\" - %s [%s] (%s)", titulo, artista, album, getTempoFormatado());
    }
}

public class OrganizadorMusicas {
    private final List<Musica> biblioteca = new ArrayList<>();

    public void adicionarMusica(String titulo, String artista, String album, int duracaoSegundos) {
        Musica musica = new Musica(titulo, artista, album, duracaoSegundos);
        biblioteca.add(musica);
        System.out.println("✅ Música \"" + titulo + "\" adicionada à biblioteca.");
    }

    public void removerMusica(String titulo) {
        boolean removido = biblioteca.removeIf(m -> m.getTitulo().equalsIgnoreCase(titulo));
        if (removido) {
            System.out.println("✅ Música \"" + titulo + "\" removida da biblioteca.");
        } else {
            System.out.println("❌ Música \"" + titulo + "\" não foi encontrada.");
        }
    }

    public void listarBiblioteca() {
        System.out.println("\n🎶 BIBLIOTECA MUSICAL:");
        if (biblioteca.isEmpty()) {
            System.out.println("(Nenhuma música cadastrada)");
            return;
        }
        for (int i = 0; i < biblioteca.size(); i++) {
            System.out.println((i + 1) + ". " + biblioteca.get(i));
        }
    }

    public void tocarPlaylist() {
        System.out.println("\n▶️ Iniciando reprodução da biblioteca...");
        if (biblioteca.isEmpty()) {
            System.out.println("❌ Nenhuma música na playlist para reproduzir!");
            return;
        }
        for (Musica m : biblioteca) {
            System.out.println("🔊 Tocando agora: " + m.getTitulo() + " por " + m.getArtista() + "...");
            try {
                Thread.sleep(500); // Pausa rápida para simular a troca de faixas
            } catch (InterruptedException e) {
                Thread.currentThread().interrupt();
            }
        }
        System.out.println("⏹️ Fim da playlist.");
    }

    public void embaralharEPlay() {
        System.out.println("\n🔀 Modo Aleatório Ativado!");
        List<Musica> embaralhado = new ArrayList<>(biblioteca);
        Collections.shuffle(embaralhado);
        for (Musica m : embaralhado) {
            System.out.println("🔊 [Aleatório] Tocando agora: " + m.getTitulo() + " - " + m.getArtista());
        }
    }

    public static void main(String[] args) {
        OrganizadorMusicas organizador = new OrganizadorMusicas();
        Scanner scanner = new Scanner(System.in);
        
        // Músicas de demonstração
        organizador.adicionarMusica("Imagine", "John Lennon", "Imagine", 183);
        organizador.adicionarMusica("Hotel California", "Eagles", "Hotel California", 390);
        organizador.adicionarMusica("Billie Jean", "Michael Jackson", "Thriller", 294);

        boolean ativo = true;
        while (ativo) {
            System.out.println("\n=== 🎵 ORGANIZADOR DE MÚSICAS ===");
            System.out.println("1. Listar Biblioteca");
            System.out.println("2. Adicionar Música");
            System.out.println("3. Remover Música");
            System.out.println("4. Tocar Todas (Sequencial)");
            System.out.println("5. Tocar Todas (Aleatório)");
            System.out.println("6. Sair");
            System.out.print("Opção: ");

            try {
                String input = scanner.nextLine().trim();
                int opcao = Integer.parseInt(input);

                switch (opcao) {
                    case 1:
                        organizador.listarBiblioteca();
                        break;
                    case 2:
                        System.out.print("Título da música: ");
                        String tit = scanner.nextLine().trim();
                        System.out.print("Artista: ");
                        String art = scanner.nextLine().trim();
                        System.out.print("Álbum: ");
                        String alb = scanner.nextLine().trim();
                        System.out.print("Duração em segundos (ex: 240): ");
                        int seg = Integer.parseInt(scanner.nextLine().trim());
                        
                        organizador.adicionarMusica(tit, art, alb, seg);
                        break;
                    case 3:
                        System.out.print("Título da música a remover: ");
                        String titRem = scanner.nextLine().trim();
                        organizador.removerMusica(titRem);
                        break;
                    case 4:
                        organizador.tocarPlaylist();
                        break;
                    case 5:
                        organizador.embaralharEPlay();
                        break;
                    case 6:
                        ativo = false;
                        System.out.println("Fechando organizador de músicas. 👋");
                        break;
                    default:
                        System.out.println("❌ Opção inválida!");
                }
            } catch (NumberFormatException e) {
                System.out.println("❌ Entrada inválida! Digite números onde solicitado.");
            } catch (IllegalArgumentException e) {
                System.out.println("❌ Erro de validação: " + e.getMessage());
            } catch (Exception e) {
                System.out.println("❌ Erro: " + e.getMessage());
            }
        }
        scanner.close();
    }
}
