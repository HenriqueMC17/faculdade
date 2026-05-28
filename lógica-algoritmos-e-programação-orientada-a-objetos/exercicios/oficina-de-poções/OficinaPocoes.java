package exercicios;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Scanner;

class Ingrediente {
    private String nome;
    private String elemento;

    public Ingrediente(String nome, String elemento) {
        this.nome = nome;
        this.elemento = elemento;
    }

    public String getNome() { return nome; }
    public String getElemento() { return elemento; }

    @Override
    public String toString() {
        return nome + " (" + elemento + ")";
    }
}

public class OficinaPocoes {
    private final List<Ingrediente> inventario = new ArrayList<>();

    public OficinaPocoes() {
        // Ingredientes iniciais do mago
        inventario.add(new Ingrediente("Pó de Estrela", "Cosmos"));
        inventario.add(new Ingrediente("Lágrima de Fênix", "Fogo/Cura"));
        inventario.add(new Ingrediente("Asa de Morcego", "Trevas"));
        inventario.add(new Ingrediente("Orvalho da Manhã", "Água"));
        inventario.add(new Ingrediente("Raiz de Mandrágora", "Terra"));
    }

    public void mostrarInventario() {
        System.out.println("\n🎒 SEU INVENTÁRIO DE INGREDIENTES:");
        for (int i = 0; i < inventario.size(); i++) {
            System.out.println((i + 1) + ". " + inventario.get(i));
        }
    }

    public void misturarIngredientes(int idx1, int idx2) {
        if (idx1 < 0 || idx1 >= inventario.size() || idx2 < 0 || idx2 >= inventario.size()) {
            System.out.println("❌ Índices de ingredientes inválidos!");
            return;
        }
        if (idx1 == idx2) {
            System.out.println("❌ Você deve escolher dois ingredientes diferentes!");
            return;
        }

        Ingrediente ing1 = inventario.get(idx1);
        Ingrediente ing2 = inventario.get(idx2);

        System.out.println("\n🔮 Misturando " + ing1.getNome() + " + " + ing2.getNome() + " no caldeirão...");
        
        String resultado = combinar(ing1.getNome(), ing2.getNome());
        System.out.println("✨ O caldeirão brilha intensamente! ✨");
        System.out.println("🧪 Você obteve: " + resultado);

        // Remove os ingredientes consumidos (do maior índice para o menor para não deslocar)
        if (idx1 > idx2) {
            inventario.remove(idx1);
            inventario.remove(idx2);
        } else {
            inventario.remove(idx2);
            inventario.remove(idx1);
        }
    }

    private String combinar(String nome1, String nome2) {
        String n1 = nome1.toLowerCase();
        String n2 = nome2.toLowerCase();

        if ((n1.contains("estrela") && n2.contains("fênix")) || (n1.contains("fênix") && n2.contains("estrela"))) {
            return "💥 POÇÃO DE SUPERNOVA (Cura extrema e energia cósmica)";
        }
        if ((n1.contains("morcego") && n2.contains("raiz")) || (n1.contains("raiz") && n2.contains("morcego"))) {
            return "☠️ POÇÃO DE VENENO DA FLORESTA (Altamente tóxica)";
        }
        if ((n1.contains("orvalho") && n2.contains("estrela")) || (n1.contains("estrela") && n2.contains("orvalho"))) {
            return "💧 POÇÃO DE CLARIVIDÊNCIA (Permite enxergar o futuro oculto)";
        }
        if ((n1.contains("orvalho") && n2.contains("fênix")) || (n1.contains("fênix") && n2.contains("orvalho"))) {
            return "🔥 POÇÃO DE VAPOR SAGRADO (Cria uma névoa curativa)";
        }
        return "💨 POÇÃO FRACASSADA (Apenas uma fumaça cinza sem efeito...)";
    }

    public void colherIngrediente(String nome, String elemento) {
        inventario.add(new Ingrediente(nome, elemento));
        System.out.println("✅ Você colheu: " + nome);
    }

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        OficinaPocoes oficina = new OficinaPocoes();
        System.out.println("🔮 BEM-VINDO À OFICINA DE POÇÕES DO MAGO 🔮");

        boolean ativo = true;
        while (ativo) {
            System.out.println("\nEscolha uma ação:");
            System.out.println("1. Ver inventário de ingredientes");
            System.out.println("2. Preparar poção no Caldeirão");
            System.out.println("3. Ir à floresta colher ingrediente");
            System.out.println("4. Sair da oficina");
            System.out.print("Sua ação: ");

            try {
                String input = scanner.nextLine().trim();
                int opcao = Integer.parseInt(input);

                switch (opcao) {
                    case 1:
                        oficina.mostrarInventario();
                        break;
                    case 2:
                        oficina.mostrarInventario();
                        if (oficina.inventario.size() < 2) {
                            System.out.println("❌ Você não tem ingredientes suficientes no inventário!");
                            break;
                        }
                        System.out.print("\nEscolha o número do 1º ingrediente: ");
                        int idx1 = Integer.parseInt(scanner.nextLine().trim()) - 1;
                        System.out.print("Escolha o número do 2º ingrediente: ");
                        int idx2 = Integer.parseInt(scanner.nextLine().trim()) - 1;
                        
                        oficina.misturarIngredientes(idx1, idx2);
                        break;
                    case 3:
                        System.out.println("\n🌲 Você caminha pela floresta escura...");
                        System.out.println("1. Colher Cogumelo Fluorescente");
                        System.out.println("2. Coletar Essência de Fogo");
                        System.out.print("Opção: ");
                        int escolhaColheita = Integer.parseInt(scanner.nextLine().trim());
                        if (escolhaColheita == 1) {
                            oficina.colherIngrediente("Cogumelo Fluorescente", "Luz");
                        } else if (escolhaColheita == 2) {
                            oficina.colherIngrediente("Essência de Fogo", "Fogo");
                        } else {
                            System.out.println("❌ Opção inválida! Você voltou de mãos vazias.");
                        }
                        break;
                    case 4:
                        ativo = false;
                        System.out.println("Fechando a oficina de poções. Que a magia esteja com você! 🧙‍♂️👋");
                        break;
                    default:
                        System.out.println("❌ Opção inválida!");
                }
            } catch (NumberFormatException e) {
                System.out.println("❌ Entrada inválida! Digite apenas números.");
            } catch (Exception e) {
                System.out.println("❌ Erro: " + e.getMessage());
            }
        }
        scanner.close();
    }
}
