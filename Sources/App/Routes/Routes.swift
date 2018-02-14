import Vapor

extension Droplet {
    func setupRoutes() throws {
        
        let userController = UserController(drop: self)
        userController.addRoutes()
        let rideController = RideController(drop: self)
        rideController.addRoutes()
    }
}
