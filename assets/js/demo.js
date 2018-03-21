export const CreateChart = {
    draw: () => {
        Draggable.create(".box", {type:"x,y", edgeResistance:0.65, bounds:"#container", throwProps:true});
    }
}
