import Foundation
//Luca Saboia
//Ana Gabrielle da Silva Oliveira
//Eduardo Oliveira
//André Cintra


//Codigo dia 1
public class Pessoa{
    var nome: String
    var email: String
    
    init(nome: String, email: String) { 
        self.nome = nome
        self.email = email
    }


    public func getDescricao() -> String {
        return "Nome: \(nome) | Email: \(email) "
    }

    enum NivelAluno{
        case iniciante
        case intermediario
        case avancado
    }
}

public class Aluno: Pessoa{
    var matricula: String
    var nivel: NivelAluno = .iniciante
    public private(set) var plano: Plano

    init(nome: String, email: String, matricula: String, plano: Plano){
        self.matricula = matricula
        self.plano = plano
        super.init(nome: nome, email: email)
    }
    

    public override func getDescricao() -> String {
        return super.getDescricao() + "| Matricula: \(matricula) | Plano: \(plano.nome)"
    }
}

public class Instrutor: Pessoa{
    var especialidade: String

    init(nome: String, email: String, especialidade: String){
        self.especialidade = especialidade
        super.init(nome: nome, email: email)
    }

    public override func getDescricao() -> String {
        return super.getDescricao() + "| Especialidade \(especialidade)"
    }
}

public class Plano{
    var nome: String
    
    init(nome: String){
        self.nome = nome
    }

    func calcularMensalidade() -> Double{
        return 0.0
    }
}

public class PlanoMensal: Plano{
    init(){
        super.init(nome: "Plano Mensal")
    }
    override func calcularMensalidade() -> Double{
        return 120.0
    }
}

public class PlanoAnual : Plano {
    init() {
        super.init(nome: "Plano Anual (Promocional)")
    }

    override func calcularMensalidade() -> Double {
        return 120 * 0.8 
    }
}

//Código dia 2

protocol Manutencao {
    var nomeItem: String { get set }
    var dataUltimaManutencao: String { get }
    
    func realizarManutencao() -> Bool 
}

public class Aparelho: Manutencao {
    var nomeItem: String
    public private(set) var dataUltimaManutencao: String = "Nenhuma"

    
    init(nomeItem: String){
        self.nomeItem = nomeItem
    }
    
    func realizarManutencao() -> Bool {
        dataUltimaManutencao = "04/12/2025"
        return true
    }
}

public class Aula {
    var nome: String
    var instrutor: Instrutor
    
    init(nome: String, instrutor: Instrutor) {
        self.nome = nome
        self.instrutor = instrutor
    }
    
    public func getDescricao() -> String {
        return "Tipo de aula: \(nome) | Instrutor: \(instrutor.nome)"
    }
}

public class AulaPersonal: Aula {
    var aluno: Aluno
    
    init(nome: String, instrutor: Instrutor, aluno: Aluno) {
        self.aluno = aluno
        super.init(nome: nome, instrutor: instrutor)
    }
    
    public override func getDescricao() -> String {
        return "Aluno que sera treinado: \(aluno.nome)"
    }
}

public class AulaColetiva: Aula {
    private(set) var alunosInscritos: [String: Aluno] = [:]
    var capacidadeMaxima: Int
    
    init(nome: String, instrutor: Instrutor, capacidadeMaxima: Int) {
        self.capacidadeMaxima = capacidadeMaxima
        super.init(nome: nome, instrutor: instrutor)
    }
    
    public func inscrever(aluno: Aluno) -> Bool {
        if alunosInscritos.count >= capacidadeMaxima{
            print("Capacidade maxima atingida")
            return false
        }

        if alunosInscritos[aluno.matricula] != nil {
            print("O aluno já está inscrito.")
            return false
        }
        
        alunosInscritos[aluno.matricula] = aluno
        print("Aluno inscrito com sucesso!")
        return true
        
        
    }
    public override func getDescricao() -> String {
        return super.getDescricao() + " | Capacidade Máxima: \(capacidadeMaxima) | Vagas Ocupadas: \(alunosInscritos.count) "
    }
}

//Codigo dia 3

public class Academia{
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
        instrutoresContratados[instrutor.email] = instrutor
    }
    
    func matricularAluno(_ aluno: Aluno) {
        let matricula = aluno.matricula
        if alunosMatriculados[matricula] != nil {
            print("Erro: Aluno com matrícula \(matricula) já existe")
        } else{
            alunosMatriculados[matricula] = aluno
            print("Aluno adicionado com sucesso")
        }
    }
    
    func matricularAluno(nome: String, email: String, matricula: String, plano: Plano) -> Aluno {
        let novoAluno = Aluno(nome: nome, email: email, matricula: matricula, plano: plano)
        
        if let alunoMatriculado = buscarAluno(matricula: novoAluno.matricula) {
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


//Codigo dia 4
var academia = Academia(nome: "Academia POO 360", alunosMatriculados: [:], instrutoresContratados: [:], aparelhos: [], aulasDisponiveis: [])

var planoMensal = PlanoMensal()
var planoAnual = PlanoAnual()

var instrutor1 = Instrutor(nome: "Joao", email: "joao.santo@gmail.com", especialidade: "Professor de Crossfit")
var instrutor2 = Instrutor(nome: "Larissa", email: "larissa.almeida@gmail.com", especialidade: "Personal")

academia.contratarInstrutor(instrutor1)
academia.contratarInstrutor(instrutor2)

var aluno1 = academia.matricularAluno(nome: "Jose", email: "josesilva@gmail.com", matricula: "00001", plano: planoMensal)
var aluno2 = academia.matricularAluno(nome: "Carlos", email: "carlos.bueno@gmail.com", matricula: "00002", plano: planoAnual)

academia.matricularAluno(aluno1)
academia.matricularAluno(aluno2)

var aulaPersonal = AulaPersonal(nome: "Aula Particular", instrutor: instrutor1, aluno: aluno1)
var aulaColetiva = AulaColetiva(nome: "Aula em Grupo", instrutor: instrutor2, capacidadeMaxima: 3)

academia.adicionarAula(aulaPersonal)
academia.adicionarAula(aulaColetiva)

if aulaColetiva.inscrever(aluno: aluno1) {
    academia.matricularAluno(aluno1)
}
if aulaColetiva.inscrever(aluno: aluno2) {
    academia.matricularAluno(aluno2)
}

var aluno3 = academia.matricularAluno(nome: "Eduarda", email: "eduarda@gmail.com", matricula: "00003", plano: planoAnual)
if aulaColetiva.inscrever(aluno: aluno3) {
    academia.matricularAluno(aluno3)
}

var aluno4 = academia.matricularAluno(nome: "Felipe", email: "Felipe@gmail.com", matricula: "00004", plano: planoMensal)
if aulaColetiva.inscrever(aluno: aluno4) {
    academia.matricularAluno(aluno4)
}

academia.listarAulas()
academia.listarAlunos()

var aulas: [Aula] = []
aulas.append(aulaPersonal)
aulas.append(aulaColetiva)
for aula in aulas {
    print(aula.getDescricao())
}

var pessoas: [Pessoa] = []
pessoas.append(instrutor1)
pessoas.append(instrutor2)
pessoas.append(aluno1)
pessoas.append(aluno2)
pessoas.append(aluno3)
pessoas.append(aluno4)
for pessoa in pessoas {
    print(pessoa.getDescricao())
}

extension Academia {
    func gerarRelatorio() -> (totalAlunos: Int, totalInstrutores: Int, totalAulas: Int) {
        return (totalAlunos: alunosMatriculados.count, totalInstrutores: instrutoresContratados.count, totalAulas: aulasDisponiveis.count)
    }
}

let relatorio = academia.gerarRelatorio()
print()
print("Total de alunos: \(relatorio.totalAlunos)")
print("Total de instrutores: \(relatorio.totalInstrutores)")
print("Total de aulas: \(relatorio.totalAulas)")

