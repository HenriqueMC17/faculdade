package exercicios;

import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

class Livro {
    private String titulo;
    private String autor;
    private String isbn;
    private boolean disponivel;

    public Livro(String titulo, String autor, String isbn) {
        this.titulo = titulo;
        this.autor = autor;
        this.isbn = isbn;
        this.disponivel = true;
    }

    public String getTitulo() { return titulo; }
    public String getAutor() { return autor; }
    public String getIsbn() { return isbn; }
    public boolean isDisponivel() { return disponivel; }

    public void emprestar() {
        this.disponivel = false;
    }

    public void devolver() {
        this.disponivel = true;
    }

    @Override
    public String toString() {
        return "Livro: \"" + titulo + "\" por " + autor + " (ISBN: " + isbn + ") - [" + (disponivel ? "DISPONÍVEL" : "EMPRESTADO") + "]";
    }
}

class Usuario {
    private String nome;
    private String matricula;
    private List<Livro> livrosEmprestados;

    public Usuario(String nome, String matricula) {
        this.nome = nome;
        this.matricula = matricula;
        this.livrosEmprestados = new ArrayList<>();
    }

    public String getNome() { return nome; }
    public String getMatricula() { return matricula; }
    public List<Livro> getLivrosEmprestados() { return livrosEmprestados; }

    public void pegarLivro(Livro livro) {
        livrosEmprestados.add(livro);
    }

    public void devolverLivro(Livro livro) {
        livrosEmprestados.remove(livro);
    }
}

public class BibliotecaDigital {
    private List<Livro> acervo = new ArrayList<>();
    private List<Usuario> usuarios = new ArrayList<>();

    public void cadastrarLivro(String titulo, String autor, String isbn) {
        acervo.add(new Livro(titulo, autor, isbn));
        System.out.println("✅ Livro \"" + titulo + "\" cadastrado no acervo.");
    }

    public void cadastrarUsuario(String nome, String matricula) {
        usuarios.add(new Usuario(nome, matricula));
        System.out.println("✅ Usuário " + nome + " registrado com matrícula " + matricula + ".");
    }

    public Livro buscarLivroPorIsbn(String isbn) {
        for (Livro livro : acervo) {
            if (livro.getIsbn().equalsIgnoreCase(isbn)) {
                return livro;
            }
        }
        return null;
    }

    public Usuario buscarUsuarioPorMatricula(String matricula) {
        for (Usuario usuario : usuarios) {
            if (usuario.getMatricula().equalsIgnoreCase(matricula)) {
                return usuario;
            }
        }
        return null;
    }

    public void emprestarLivro(String matricula, String isbn) {
        Usuario usuario = buscarUsuarioPorMatricula(matricula);
        Livro livro = buscarLivroPorIsbn(isbn);

        if (usuario == null) {
            System.out.println("❌ Usuário não encontrado!");
            return;
        }
        if (livro == null) {
            System.out.println("❌ Livro não encontrado no acervo!");
            return;
        }
        if (!livro.isDisponivel()) {
            System.out.println("❌ O livro \"" + livro.getTitulo() + "\" já está emprestado.");
            return;
        }

        livro.emprestar();
        usuario.pegarLivro(livro);
        System.out.println("📖 Livro \"" + livro.getTitulo() + "\" emprestado com sucesso para " + usuario.getNome() + ".");
    }

    public void devolverLivro(String matricula, String isbn) {
        Usuario usuario = buscarUsuarioPorMatricula(matricula);
        Livro livro = buscarLivroPorIsbn(isbn);

        if (usuario == null) {
            System.out.println("❌ Usuário não encontrado!");
            return;
        }
        if (livro == null) {
            System.out.println("❌ Livro não encontrado no acervo!");
            return;
        }

        if (usuario.getLivrosEmprestados().contains(livro)) {
            livro.devolver();
            usuario.devolverLivro(livro);
            System.out.println("🔄 Livro \"" + livro.getTitulo() + "\" devolvido por " + usuario.getNome() + ".");
        } else {
            System.out.println("❌ Este usuário não possui o livro \"" + livro.getTitulo() + "\" emprestado.");
        }
    }

    public void mostrarAcervo() {
        System.out.println("\n📚 ACERVO DA BIBLIOTECA DIGITAL:");
        if (acervo.isEmpty()) {
            System.out.println("(Nenhum livro cadastrado)");
        } else {
            for (Livro livro : acervo) {
                System.out.println(livro);
            }
        }
    }

    public static void main(String[] args) {
        BibliotecaDigital biblioteca = new BibliotecaDigital();
        
        // Dados de teste iniciais
        biblioteca.cadastrarLivro("Java: Como Programar", "Deitel", "111");
        biblioteca.cadastrarLivro("Código Limpo", "Robert C. Martin", "222");
        biblioteca.cadastrarUsuario("Ana Silva", "U01");

        Scanner scanner = new Scanner(System.in);
        boolean executando = true;

        while (executando) {
            System.out.println("\n=== 🖥️ MENU BIBLIOTECA DIGITAL ===");
            System.out.println("1. Mostrar Acervo");
            System.out.println("2. Emprestar Livro");
            System.out.println("3. Devolver Livro");
            System.out.println("4. Cadastrar Livro");
            System.out.println("5. Cadastrar Usuário");
            System.out.println("6. Sair");
            System.out.print("Escolha uma opção: ");

            try {
                String input = scanner.nextLine().trim();
                int opcao = Integer.parseInt(input);

                switch (opcao) {
                    case 1:
                        biblioteca.mostrarAcervo();
                        break;
                    case 2:
                        System.out.print("Matrícula do Usuário: ");
                        String matEmp = scanner.nextLine().trim();
                        System.out.print("ISBN do Livro: ");
                        String isbnEmp = scanner.nextLine().trim();
                        biblioteca.emprestarLivro(matEmp, isbnEmp);
                        break;
                    case 3:
                        System.out.print("Matrícula do Usuário: ");
                        String matDev = scanner.nextLine().trim();
                        System.out.print("ISBN do Livro: ");
                        String isbnDev = scanner.nextLine().trim();
                        biblioteca.devolverLivro(matDev, isbnDev);
                        break;
                    case 4:
                        System.out.print("Título do Livro: ");
                        String tit = scanner.nextLine().trim();
                        System.out.print("Autor: ");
                        String aut = scanner.nextLine().trim();
                        System.out.print("ISBN: ");
                        String isbn = scanner.nextLine().trim();
                        
                        if (tit.isEmpty() || aut.isEmpty() || isbn.isEmpty()) {
                            System.out.println("❌ Campos de livro não podem ser vazios!");
                        } else {
                            biblioteca.cadastrarLivro(tit, aut, isbn);
                        }
                        break;
                    case 5:
                        System.out.print("Nome do Usuário: ");
                        String nom = scanner.nextLine().trim();
                        System.out.print("Matrícula: ");
                        String mat = scanner.nextLine().trim();
                        
                        if (nom.isEmpty() || mat.isEmpty()) {
                            System.out.println("❌ Campos de usuário não podem ser vazios!");
                        } else {
                            biblioteca.cadastrarUsuario(nom, mat);
                        }
                        break;
                    case 6:
                        executando = false;
                        System.out.println("Fechando sistema da Biblioteca. Obrigado! 👋");
                        break;
                    default:
                        System.out.println("❌ Opção inválida!");
                }
            } catch (NumberFormatException e) {
                System.out.println("❌ Digite um número válido.");
            } catch (Exception e) {
                System.out.println("❌ Ocorreu um erro: " + e.getMessage());
            }
        }
        scanner.close();
    }
}
