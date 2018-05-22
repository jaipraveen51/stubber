pragma solidity 0.4.23;

import "zeppelin-solidity/contracts/token/ERC721/ERC721Token.sol";
import "zeppelin-solidity/contracts/ownership/Ownable.sol";

contract StubToken is ERC721Token, Ownable {

    constructor(string _name,string _symbol)
    ERC721Token(_name, _symbol) public {

    }

    event NewEvent(uint _eventId);

    struct Ticket {
        uint eventId;
        uint price;
    }

    struct Event {
        bytes32 name;
        bytes32 location;
        uint price;
        uint time;
    }

    Ticket[] public tickets;
    Event[] public events;

    function getTicket(uint _ticketId) public view returns(uint eventId, uint price) {
        Ticket memory _ticket = tickets[_ticketId];

        eventId = _ticket.eventId;
        price = _ticket.price;
    }

    function getEvent(uint _eventId) public view returns(bytes32 name, bytes32 location, uint price, uint time) {
        Event memory _event = events[_eventId];

        name = _event.name;
        location = _event.location;
        price = _event.price;
        time = _event.time;
    }

    function mint(uint _event, uint _price) public onlyOwner {
        Ticket memory _ticket = Ticket({
            eventId: _event,
            price: _price
        });
        uint _ticketId = tickets.push(_ticket) - 1;

        _mint(msg.sender, _ticketId);
    }

    function createEvent(bytes32 _name, bytes32 _location, uint _price, uint _time) public onlyOwner {
        Event memory _event = Event({
            name: _name,
            location: _location,
            price: _price,
            time: _time
        });
        uint eventId = events.push(_event) - 1;
        emit NewEvent(eventId);
    }
}