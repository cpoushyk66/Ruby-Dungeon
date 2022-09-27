import React from "react";

function ShopItem({updateCurrentCharacter, character, buying, item}) {

    function handleBuy(e) {
        e.preventDefault()

        if (character.gold >= item.value)
        {
            fetch(`/characters/${character.id}/buy/${item.id}`)
            .then(res => {
                if (res.ok) {
                    res.json().then(updateCurrentCharacter)
                }
                else {
                    
                }
            })
        }
        
    }

    function handleSell(e)
    {
        e.preventDefault()

        if (item.sellable)
        {
            fetch(`/characters/${character.id}/sell/${item.id}`)
            .then(res => {
                if (res.ok) {
                    res.json().then(updateCurrentCharacter)
                }
                else {
                    
                }
            })
        }
    }

    return (
        <div className="single" >
            <p>{item.name}</p>
            <p>{item.flavor_text}</p>
            <p>Cost {item.value} gold!</p>
            {buying ? <button onClick={handleBuy}>Buy</button> : <button onClick={handleSell} >{item.sellable ? "Sell" : "Unsellable"}</button>}
        </div>
    )
}

export default ShopItem