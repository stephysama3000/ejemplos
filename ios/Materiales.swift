

class Materiales{
    
    // MARK: Properties
    
    var materia: String
    var numMateriales: Int
    var imagen : UIImage
    
    // MARK: Initialization
    
    init?(materia: String, numMateriales: Int, imagen: UIImage)
    {
        // Initialize stored properties.
        self.materia = materia
        self.numMateriales = numMateriales
        self.imagen = imagen
    }
    
}
