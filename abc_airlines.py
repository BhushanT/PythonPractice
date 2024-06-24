class Flight:
    def __init__(self, flight_number, departure_city, arrival_city, departure_time, seat_capacity=150):
        self.flight_number = flight_number
        self.departure_city = departure_city
        self.arrival_city = arrival_city
        self.departure_time = departure_time
        self.seat_capacity = seat_capacity
        self.passenger_list = []

    def add_passenger(self, passenger_name):
        if len(self.passenger_list) < self.seat_capacity:
            self.passenger_list.append(passenger_name)
            print(f"Passenger {passenger_name} added.")
        else:
            print("The flight is full.")

    def remove_passenger(self, passenger_name):
        if passenger_name in self.passenger_list:
            self.passenger_list.remove(passenger_name)
            print(f"Passenger {passenger_name} removed.")
        else:
            print(f"Passenger {passenger_name} is not on the flight.")

    def log_flight(self):
        with open("flight_log.txt", "a") as log_file:
            log_file.write(f"{self.flight_number}, {self.departure_city}, {self.arrival_city}, {len(self.passenger_list)}\n")
        print(f"Flight {self.flight_number} logged.")

    def check_availability(self):
        return self.seat_capacity - len(self.passenger_list)

    def __repr__(self):
        return (f"Flight {self.flight_number} from {self.departure_city} to {self.arrival_city}")


# Example usage:
flight = Flight("AB123", "New York", "London", "2024-06-24 18:00")
print(flight)

flight.add_passenger("Bhushan Thumsi")
flight.add_passenger("Lebron James")
print(f"Available seats: {flight.check_availability()}")

flight.remove_passenger("John Doe")
flight.remove_passenger("Lebron James")
print(f"Available seats: {flight.check_availability()}")


flight.log_flight()
print(flight)
