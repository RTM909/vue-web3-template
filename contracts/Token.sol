//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";

contract Token is ERC1155{
    address public platform;

    constructor() ERC1155(""){
        platform = msg.sender;
    }

    struct Property {
        uint256 id;
        string name;
        string description;
        string city;
        string state;
        string country;
        string location;
        string price;
        uint lockin;
        string tokenURI;
        address to;
    }   
   // mapping(uint =>string) public names;
    uint idlenght = 0;
    //uint public len = 10 ;
     Property[] public Propertylist;
       mapping(address =>mapping(string => uint)) public invetments;


    function mint(
    string memory name,
    string memory description,
    string memory city,
    string memory state ,
    string memory country,
    string memory location,
    string memory price ,
    uint160 supply,
    uint lockin,
    string memory tokenURI,
    address to
    )
    public
    {
            uint256 id = Propertylist.length;
            Propertylist.push(
            Property(
                id,
                name,
                description,
                city,
                state,
                country,
                location,
                price,
                lockin,
                tokenURI,
                to
            )
        );

            _mint(to,id,supply,"");
            setApprovalForAll(platform,true);
    }

    function le() public view returns(uint){
        uint len = Propertylist.length;
        return(len);
    }

     function invest(address from ,uint id, uint amount,string memory name) public {
        _safeTransferFrom(from,msg.sender,id,amount,"");
        invetments[msg.sender][name];

     }
     function viewInvestments(address user, string memory name) public view  returns (uint) {
        uint id =(invetments[user][name]);
        return(balanceOf(msg.sender,id));
    }

    function vb(address user,uint id) public view returns(uint){
        return(balanceOf(user,id));
    }
}