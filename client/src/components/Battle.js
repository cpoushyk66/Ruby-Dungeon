import React, { useEffect, useState } from "react";

function Battle({character, enemies}) {

    const [enemyDatas, setEnemyDatas] = useState(null)
    useEffect(() => {
        fetch(`/enemies/random/${enemies}`)
        .then(res => res.json())
        .then(setEnemyDatas)
    }, [])

    function formatEnemies()  {
        return enemyDatas.map(enemy => {
        return <div>
            <p>{enemy.name} the {enemy.race}</p>
            <p>Level: {enemy.level}</p>
            <p>Health: {enemy.hp_current} / {enemy.hp_max}</p>

        </div>
    })
    }
    return (
        <div style={{"backgroundColor": "white"}}>
            BATTTLE
            <div>{enemyDatas != null ? formatEnemies() : null}</div>
        </div>
    )
}

export default Battle