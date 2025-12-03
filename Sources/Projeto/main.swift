//Luca Saboia
//Ana Gabrielle da Silva Oliveira
//Eduardo Oliveira
//André Cintra


//Codigo dia 1
public class Pessoa{
    private var nome: String
    private var email: String

    public func getDescricao() -> String{
        return "Nome: \(nome) | Email: \(email) "
    }

    enum NivelAluno(){
        case iniciante
        case intermediario
        case avancado
    }
}

public class Aluno: Pessoa{
    private(set) var matricula: String
    private var nivel: NivelAluno = .iniciante
    private(set) var plano: Plano

    init(nome: String, email: String, matricula: String, plano: Plano){
        self.matricula = matricula
        self.plano = plano
        super.init(nome, email)
    }

    public override func getDescricao(){
        return super.getDescricao() + "| Matricula: \(matricula) | Plano: \(plano)"
    }
}

public class Instrutor: Pessoa{
    private var especialidade: String

    init(nome: String, email: String, especialidade: String){
        self.especialidade = especialidade
        super.init(nome, email)
    }

    public override func getDescricao(){
        return super.getDescricao() + "| Especialidade \(especialidade)"
    }
}

class Plano{
    var nome: String
    
    init(nome: String){
        self.nome = nome
    }

    func calcularMensalidade() -> Double{
        return 0.0
    }
}

class PlanoMensal: Plano{
    init(){
        super.init(nome: "Plano Mensal")
    }
    override func calcularMensalidade() -> Double{
        return 120.0
    }
}

class PlanoAnual : Plano {
    init() {
        super.init(nome: "Plano Anual (Promocional)")
    }

    override func calcularMensalidade() -> Double {
        return 120 * 0.8 
    }
}

//Codigo dia 3

class Academia{
    private let nome: String
    private var alunosMatriculados: [String: Aluno]
    private var instrutoresContratados: [String: Instrutor]
    private var aparelhos: [Aparelho]
    private var aulasDisponiveis: [Aula]
    
    init (nome: String, alunosMatriculados: [String: Aluno], instrutoresContratados: [String: Instrutor], aparelhos: [Aparelho], aulasDisponiveis: [Aula]){
        self.nome = nome
        self.alunosMatriculados = alunosMatriculados
        self.instrutoresContratados = instrutoresContratados
        self.aparelhos = aparelhos
        self.aulasDisponiveis = aulasDisponiveis
    }
    func adicionarAparelho(_ aparelho: Aparelho){
        aparelhos.append(aparelho)
    }
    func adicionarAula(_ aula: Aula){
        aulasDisponiveis.append(aula)
    }
    func contratarInstrutor(_ instrutor: Instrutor){
        instrutoresContratados.append(instrutor)
    }
    
    func matricularAluno(_ aluno: Aluno) {
        var matricula = aluno.matricula
        if let alunoMatriculado = alunosMatriculados[matricula]{
            print("Erro: Aluno com matrícula \(matricula) ja existe")
        } else{
            alunosMatriculados[matricula] = aluno
            print("Aluno adicionado com sucesso")
        }
    }
    
    func matricularAluno(nome: String, email: String, matricula: String, plano: Plano) -> Aluno {
        novoAluno = Aluno(nome: nome, email: email, matricula: matricula, plano: plano)
        
        let alunoMatriculado = buscarAluno(novoAluno) 
        
        if alunoMatriculado != nil {
            return alunoMatriculado
        }
        else {
            return novoAluno
        }
    }
    
    func buscarAluno(matricula: String) -> Aluno? {
        if let alunoMatriculado = alunosMatriculados[matricula] {
            return alunoMatriculado
        }
        return nil
    }
    
    func listarAlunos() {
        if alunosMatriculados.isEmpty {
            print("Nenhum aluno matriculado.")
        }
        else {
            print("--- Lista de Alunos Matriculados ---")
            var listaAlunos: [Aluno] = []
            for (_, aluno) in alunosMatriculados {
                listaAlunos.append(aluno)
            }
            
            listaAlunos.sort{$0.nome < $1.nome}
            
            for aluno in listaAlunos {
                print(aluno.getDescricao())
            }
            
            print("------------------------------------")
        }   
    }
    
    func listarAulas() {
        if aulasDisponiveis.isEmpty {
            print("Nenhuma aula disponível.")
        }
        else {
            print("--- Lista de Aulas Disponíveis ---")
            
            for aula in aulasDisponiveis {
                print(aula.getDescricao())
            }
            
            print("----------------------------------")
        }
    }
}
