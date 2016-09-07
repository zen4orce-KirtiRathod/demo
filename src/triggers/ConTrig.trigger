trigger ConTrig on Contact (before insert) {
    
       TriggerFactoryNew.CreateHandler('Contact');

}