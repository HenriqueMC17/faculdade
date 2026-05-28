package exercicios;

import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

class Produto {
    private int id;
    private String nome;
    private double preco;
    private int quantidadeEstoque;

    public Produto(int id, String nome, double preco, int quantidadeEstoque) {
        if (nome == null || nome.trim().isEmpty()) {
            throw new IllegalArgumentException("Nome do produto é obrigatório.");
        }
        if (preco <= 0) {
            throw new IllegalArgumentException("O preço deve ser maior que zero.");
        }
        if (quantidadeEstoque < 0) {
            throw new IllegalArgumentException("A quantidade em estoque não pode ser negativa.");
        }
        this.id = id;
        this.nome = nome;
        this.preco = preco;
        this.quantidadeEstoque = quantidadeEstoque;
    }

    public int getId() { return id; }
    public String getNome() { return nome; }
    public double getPreco() { return preco; }
    public int getQuantidadeEstoque() { return quantidadeEstoque; }

    public void setPreco(double preco) {
        if (preco <= 0) throw new IllegalArgumentException("Preço inválido.");
        this.preco = preco;
    }

    public void reporEstoque(int quant) {
        if (quant <= 0) throw new IllegalArgumentException("Quantidade deve ser maior que zero.");
        this.quantidadeEstoque += quant;
    }

    public void darBaixaEstoque(int quant) {
        if (quant <= 0) throw new IllegalArgumentException("Quantidade deve ser maior que zero.");
        if (this.quantidadeEstoque < quant) {
            throw new IllegalStateException("Estoque insuficiente! Estoque atual: " + quantidadeEstoque);
        }
        this.quantidadeEstoque -= quant;
    }

    @Override
    public String toString() {
        return String.format("ID: %3d | Nome: %-15s | Preço: R$ %6.2f | Estoque: %d unidades", 
                id, nome, preco, quantidadeEstoque);
    }
}

public class SistemaProdutos {
    private final List<Produto> catalogo = new ArrayList<>();
    private int proximoId = 1;

    public void cadastrarProduto(String nome, double preco, int estoque) {
        catalogo.add(new Produto(proximoId++, nome, preco, estoque));
        System.out.println("✅ Produto \"" + nome + "\" cadastrado no catálogo.");
    }

    public Produto buscarProduto(int id) {
        for (Produto p : catalogo) {
            if (p.getId() == id) {
                return p;
            }
        }
        return null;
    }

    public void exibirProdutos() {
        System.out.println("\n📦 CATÁLOGO DE PRODUTOS:");
        if (catalogo.isEmpty()) {
            System.out.println("(Nenhum produto cadastrado no momento)");
            return;
        }
        for (Produto p : catalogo) {
            System.out.println(p);
        }
    }

    public static void main(String[] args) {
        SistemaProdutos sistema = new SistemaProdutos();
        Scanner scanner = new Scanner(System.in);

        // Cadastro inicial
        sistema.cadastrarProduto("Notebook Dell", 3800.00, 15);
        sistema.cadastrarProduto("Mouse Sem Fio", 90.00, 50);
        sistema.cadastrarProduto("Teclado Mecânico", 250.00, 30);

        boolean ativo = true;
        while (ativo) {
            System.out.println("\n=== 📦 CONTROLE DE PRODUTOS E ESTOQUE ===");
            System.out.println("1. Mostrar Catálogo");
            System.out.println("2. Cadastrar Produto Novo");
            System.out.println("3. Repor Estoque de Produto");
            System.out.println("4. Realizar Venda de Produto");
            System.out.println("5. Atualizar Preço");
            System.out.println("6. Sair");
            System.out.print("Opção: ");

            try {
                String input = scanner.nextLine().trim();
                int opcao = Integer.parseInt(input);

                switch (opcao) {
                    case 1:
                        sistema.exibirProdutos();
                        break;
                    case 2:
                        System.out.print("Nome do produto: ");
                        String nome = scanner.nextLine().trim();
                        System.out.print("Preço (R$): ");
                        double preco = Double.parseDouble(scanner.nextLine().trim().replace(",", "."));
                        System.out.print("Quantidade em estoque: ");
                        int estoque = Integer.parseInt(scanner.nextLine().trim());
                        
                        sistema.cadastrarProduto(nome, preco, estoque);
                        break;
                    case 3:
                        System.out.print("ID do produto para repor estoque: ");
                        int idRep = Integer.parseInt(scanner.nextLine().trim());
                        Produto pRep = sistema.buscarProduto(idRep);
                        if (pRep == null) {
                            System.out.println("❌ Produto não encontrado!");
                            break;
                        }
                        System.out.print("Quantidade a ser adicionada: ");
                        int quantRep = Integer.parseInt(scanner.nextLine().trim());
                        pRep.reporEstoque(quantRep);
                        System.out.println("✅ Estoque do produto \"" + pRep.getNome() + "\" atualizado para " + pRep.getQuantidadeEstoque() + ".");
                        break;
                    case 4:
                        System.out.print("ID do produto vendido: ");
                        int idVenda = Integer.parseInt(scanner.nextLine().trim());
                        Produto pVenda = sistema.buscarProduto(idVenda);
                        if (pVenda == null) {
                            System.out.println("❌ Produto não encontrado!");
                            break;
                        }
                        System.out.print("Quantidade vendida: ");
                        int quantVenda = Integer.parseInt(scanner.nextLine().trim());
                        
                        pVenda.darBaixaEstoque(quantVenda);
                        double totalVenda = pVenda.getPreco() * quantVenda;
                        System.out.printf("✅ Venda concluída! Total: R$ %.2f (Estoque atual: %d)\n", totalVenda, pVenda.getQuantidadeEstoque());
                        break;
                    case 5:
                        System.out.print("ID do produto a reajustar preço: ");
                        int idPreco = Integer.parseInt(scanner.nextLine().trim());
                        Produto pPreco = sistema.buscarProduto(idPreco);
                        if (pPreco == null) {
                            System.out.println("❌ Produto não encontrado!");
                            break;
                        }
                        System.out.print("Novo Preço (R$): ");
                        double nPreco = Double.parseDouble(scanner.nextLine().trim().replace(",", "."));
                        pPreco.setPreco(nPreco);
                        System.out.println("✅ Preço do produto \"" + pPreco.getNome() + "\" reajustado para R$ " + pPreco.getPreco() + ".");
                        break;
                    case 6:
                        ativo = false;
                        System.out.println("Fechando gerenciamento de estoque. 👋");
                        break;
                    default:
                        System.out.println("❌ Opção inválida!");
                }
            } catch (NumberFormatException e) {
                System.out.println("❌ Digite valores válidos!");
            } catch (IllegalArgumentException | IllegalStateException e) {
                System.out.println("❌ Erro operacional: " + e.getMessage());
            } catch (Exception e) {
                System.out.println("❌ Erro geral: " + e.getMessage());
            }
        }
        scanner.close();
    }
}
