package exercicios;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Random;
import java.util.Scanner;

/**
 * Simulador de Álbum de Figurinhas
 * Demonstra conceitos de Programação Orientada a Objetos (Coleções, Encapsulamento, Arrays e Lógica).
 */
public class AlbumFigurinhas {
    private final int totalFigurinhas;
    private final double precoPacote;
    private final int figurinhasPorPacote;
    
    private final boolean[] album;
    private final List<Integer> repetidas;
    private int totalPacotesComprados;
    private double totalGasto;

    public AlbumFigurinhas(int totalFigurinhas, double precoPacote, int figurinhasPorPacote) {
        if (totalFigurinhas <= 0 || precoPacote <= 0 || figurinhasPorPacote <= 0) {
            throw new IllegalArgumentException("Parâmetros do álbum devem ser maiores que zero.");
        }
        this.totalFigurinhas = totalFigurinhas;
        this.precoPacote = precoPacote;
        this.figurinhasPorPacote = figurinhasPorPacote;
        this.album = new boolean[totalFigurinhas + 1]; // 1-based indexing para facilidade
        this.repetidas = new ArrayList<>();
        this.totalPacotesComprados = 0;
        this.totalGasto = 0.0;
    }

    public void comprarPacote() {
        totalPacotesComprados++;
        totalGasto += precoPacote;
        
        Random random = new Random();
        System.out.println("\n=== 📦 Abrindo Pacote #" + totalPacotesComprados + " ===");
        System.out.print("Figurinhas obtidas: ");
        
        for (int i = 0; i < figurinhasPorPacote; i++) {
            int fig = random.nextInt(totalFigurinhas) + 1;
            System.out.print("[" + fig + "] ");
            
            if (album[fig]) {
                repetidas.add(fig);
            } else {
                album[fig] = true;
            }
        }
        System.out.println();
    }

    public void mostrarStatus() {
        int coladas = 0;
        for (int i = 1; i <= totalFigurinhas; i++) {
            if (album[i]) {
                coladas++;
            }
        }
        
        double progresso = (double) coladas / totalFigurinhas * 100;
        System.out.println("\n=================================");
        System.out.println("📊 STATUS DO ÁLBUM");
        System.out.println("=================================");
        System.out.printf("Progresso: %d/%d (%.2f%%)\n", coladas, totalFigurinhas, progresso);
        System.out.println("Figurinhas Repetidas: " + repetidas.size() + " " + repetidas);
        System.out.println("Pacotes Comprados: " + totalPacotesComprados);
        System.out.printf("Total Gasto: R$ %.2f\n", totalGasto);
        
        if (coladas == totalFigurinhas) {
            System.out.println("🏆 PARABÉNS! ÁLBUM COMPLETADO COM SUCESSO!");
        } else {
            System.out.println("Ainda faltam " + (totalFigurinhas - coladas) + " figurinhas.");
        }
        System.out.println("=================================");
    }

    public void colarTodasRepetidas(AlbumFigurinhas outroAlbum) {
        System.out.println("\n🔄 Trocando repetidas com um amigo...");
        int trocadas = 0;
        List<Integer> restantes = new ArrayList<>();
        
        for (int fig : repetidas) {
            if (!outroAlbum.album[fig]) {
                outroAlbum.album[fig] = true;
                trocadas++;
            } else {
                restantes.add(fig);
            }
        }
        repetidas.clear();
        repetidas.addAll(restantes);
        
        System.out.println("Trocadas/Coladas " + trocadas + " figurinhas no álbum do amigo.");
    }

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.println("✨ BEM-VINDO AO SIMULADOR DE ÁLBUM DE FIGURINHAS ✨");
        
        int total = 50; // álbum de 50 figurinhas para demonstração rápida
        double preco = 4.00;
        int porPacote = 5;
        
        AlbumFigurinhas meuAlbum = new AlbumFigurinhas(total, preco, porPacote);
        AlbumFigurinhas albumAmigo = new AlbumFigurinhas(total, preco, porPacote);

        boolean executando = true;
        while (executando) {
            System.out.println("\nEscolha uma opção:");
            System.out.println("1. Comprar 1 Pacote (R$ 4,00)");
            System.out.println("2. Comprar 10 Pacotes (R$ 40,00)");
            System.out.println("3. Ver Status do Meu Álbum");
            System.out.println("4. Trocar Repetidas com Amigo");
            System.out.println("5. Sair");
            System.out.print("Opção: ");
            
            try {
                String input = scanner.nextLine().trim();
                int opcao = Integer.parseInt(input);
                
                switch (opcao) {
                    case 1:
                        meuAlbum.comprarPacote();
                        break;
                    case 2:
                        for (int i = 0; i < 10; i++) {
                            meuAlbum.comprarPacote();
                        }
                        break;
                    case 3:
                        meuAlbum.mostrarStatus();
                        break;
                    case 4:
                        // Simular que o amigo também compra alguns pacotes para podermos trocar
                        for (int i = 0; i < 5; i++) {
                            albumAmigo.comprarPacote();
                        }
                        meuAlbum.colarTodasRepetidas(albumAmigo);
                        break;
                    case 5:
                        executando = false;
                        System.out.println("Até a próxima Coleção! 👋");
                        break;
                    default:
                        System.out.println("❌ Opção inválida. Escolha entre 1 e 5.");
                }
            } catch (NumberFormatException e) {
                System.out.println("❌ Entrada inválida! Digite apenas números.");
            } catch (Exception e) {
                System.out.println("❌ Ocorreu um erro: " + e.getMessage());
            }
        }
        scanner.close();
    }
}
