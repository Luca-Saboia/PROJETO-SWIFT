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

//Código dia 2

protocol Manutencao {
    private var nomeItem: String 
    private var dataUltimaManutencao: String
    private var numero = Int.random(in: 1...100)
    
    public func realizarManutencao() -> Bool {
        return true
    }
}

public class Aparelho: Manutencao {
    private var nomeItem: String 
    private(set) var dataUltimaManutencao: String? = nil
    private var numero = Int.random(in: 1...100)
    
    init(nomeItem: String)
    
    public func realizarManutencao() -> Bool {
        if (numero > 92){
            return false
        } 
        dataUltimaManutencao = Date()
        return true
    }
}

public class Aula {
    private var nome: String
    private var instrutor = Instrutor(nome: "João", email: "joao.santos@gmail.com.br", especialidade: "Personal")
    public func getDescricao() -> String {
        return "Aula de Superior de \(nome) com o Instrutor \(Instrutor.nome)"
    }
}

public class AulaPersonal: Aula {
    private var aluno = Aluno(nome: "Luca", email: "luca.saboia@gmail.com", matricula: "1234ABC", plano: "Plano Mensal")
    public override func getDescricao() -> String {
        return "Sua aula sera com \(Aluno.nome)"
    }
}

public class AulaColetiva: Aula {
    private(set) var alunosInscritos: [String: Aluno] = [:]
    private var capacidadeMaxima: Int = 25
     
    public func inscrever(aluno: Aluno) -> Bool {
        if ( alunosInscritos.count > capacidadeMaxima){
            print("Capacidade maxima atingida")
            return false
        }

        for (aluno) in alunosInscritos {
            if(aluno == aluno.getMatricula){
                print("O aluno ja está inscrito")
                return false
            } else {
                alunosInscritos[aluno.matricula] = aluno
                print("O aluno foi inscrito")
                return true
            }
        }
        
        var contagem = alunosInscritos.count
        
        public override func getDescricao() -> String {
            return "Aula de Superior de \(nome) com o Instrutor \(Instrutor.nome), com capacidade máxima de \(capacidadeMaxima), e \(contagem) vagas ocupadas."
        }
        
        

        
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
