package exercicios;

import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

class ProdutoSupermercado {
    private String nome;
    private double preco;

    public ProdutoSupermercado(String nome, double preco) {
        this.nome = nome;
        this.preco = preco;
    }

    public String getNome() { return nome; }
    public double getPreco() { return preco; }
}

class ItemCarrinho {
    private ProdutoSupermercado produto;
    private int quantidade;

    public ItemCarrinho(ProdutoSupermercado produto, int quantidade) {
        this.produto = produto;
        this.quantidade = quantidade;
    }

    public ProdutoSupermercado getProduto() { return produto; }
    public int getQuantidade() { return quantidade; }

    public double getSubtotal() {
        return produto.getPreco() * quantidade;
    }
}

class CarrinhoCompras {
    private final List<ItemCarrinho> itens = new ArrayList<>();

    public void adicionarItem(ProdutoSupermercado p, int quant) {
        if (quant <= 0) return;
        itens.add(new ItemCarrinho(p, quant));
        System.out.println("🛒 " + quant + "x \"" + p.getNome() + "\" adicionado(s) ao carrinho.");
    }

    public double calcularTotalBruto() {
        double total = 0;
        for (ItemCarrinho item : itens) {
            total += item.getSubtotal();
        }
        return total;
    }

    public double calcularDesconto(double totalBruto) {
        // Descontos Progressivos:
        // Compra acima de R$ 150 -> 10% de desconto
        // Compra acima de R$ 80 -> 5% de desconto
        if (totalBruto > 150.00) {
            return totalBruto * 0.10;
        } else if (totalBruto > 80.00) {
            return totalBruto * 0.05;
        }
        return 0.0;
    }

    public void fecharCompra() {
        System.out.println("\n=============================================");
        System.out.println("🧾 CUPOM FISCAL - SUPERMERCADO INTELIGENTE");
        System.out.println("=============================================");
        if (itens.isEmpty()) {
            System.out.println("Carrinho vazio!");
            System.out.println("=============================================");
            return;
        }

        for (ItemCarrinho item : itens) {
            System.out.format("%-20s | %2dx R$ %5.2f | Subtotal: R$ %6.2f\n", 
                    item.getProduto().getNome(), 
                    item.getQuantidade(), 
                    item.getProduto().getPreco(), 
                    item.getSubtotal());
        }
        System.out.println("---------------------------------------------");
        double bruto = calcularTotalBruto();
        double desconto = calcularDesconto(bruto);
        double liquido = bruto - desconto;

        System.out.printf("Total Bruto : R$ %8.2f\n", bruto);
        if (desconto > 0) {
            System.out.printf("Desconto    : R$ %8.2f (Desconto Progressivo)\n", desconto);
        }
        System.out.printf("VALOR FINAL : R$ %8.2f\n", liquido);
        System.out.println("=============================================");
        System.out.println("Obrigado pela preferência! Volte sempre. 😊🛒");
    }
}

public class SupermercadoInteligente {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        CarrinhoCompras carrinho = new CarrinhoCompras();

        // Catálogo de produtos disponíveis
        List<ProdutoSupermercado> prateleiras = new ArrayList<>();
        prateleiras.add(new ProdutoSupermercado("Arroz 5kg", 24.90));
        prateleiras.add(new ProdutoSupermercado("Feijão Carioca 1kg", 8.50));
        prateleiras.add(new ProdutoSupermercado("Azeite de Oliva Extravirgem", 32.00));
        prateleiras.add(new ProdutoSupermercado("Leite Integral 1L", 5.20));
        prateleiras.add(new ProdutoSupermercado("Café Gourmet 500g", 18.00));

        System.out.println("🛒 BEM-VINDO AO SUPERMERCADO INTELIGENTE 🛒\n");

        boolean comprando = true;
        while (comprando) {
            System.out.println("PRODUTOS NAS PRATELEIRAS:");
            for (int i = 0; i < prateleiras.size(); i++) {
                ProdutoSupermercado p = prateleiras.get(i);
                System.out.printf("%d. %-28s | Preço: R$ %5.2f\n", (i + 1), p.getNome(), p.getPreco());
            }
            System.out.println("6. Finalizar Compra e Exibir Cupom");
            System.out.println("7. Cancelar Compra e Sair");
            System.out.print("Sua escolha: ");

            try {
                String input = scanner.nextLine().trim();
                int opcao = Integer.parseInt(input);

                if (opcao >= 1 && opcao <= 5) {
                    ProdutoSupermercado selecionado = prateleiras.get(opcao - 1);
                    System.out.print("Digite a quantidade de \"" + selecionado.getNome() + "\": ");
                    int quant = Integer.parseInt(scanner.nextLine().trim());
                    if (quant > 0) {
                        carrinho.adicionarItem(selecionado, quant);
                    } else {
                        System.out.println("❌ Quantidade deve ser maior que zero.");
                    }
                    System.out.println();
                } else if (opcao == 6) {
                    carrinho.fecharCompra();
                    comprando = false;
                } else if (opcao == 7) {
                    System.out.println("Compra cancelada. Volte sempre! 👋");
                    comprando = false;
                } else {
                    System.out.println("❌ Opção inválida!");
                }
            } catch (NumberFormatException e) {
                System.out.println("❌ Digite números inteiros válidos.");
            } catch (Exception e) {
                System.out.println("❌ Erro: " + e.getMessage());
            }
        }
        scanner.close();
    }
}
