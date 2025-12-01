//Luca Saboia
//Ana Gabrielle da Silva Oliveira
//Eduardo Oliveira
//André Cintra

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
    private var matricula: String
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
