// (function () {


//   const render = () => {
//     // document.addEventListener('DOMContentLoaded', () => {

//     // });
//   };

//   render();

// })();

const con = document.querySelector(".wrapper");
const section = document.querySelector(".main");
const side = document.querySelector('.side');
let currentDroppable = null;

const moveContainer = (e) => {
  if (!e.target.classList.contains("item")) return;
  let shiftX = e.clientX - e.target.getBoundingClientRect().left;
  let shiftY = e.clientY - e.target.getBoundingClientRect().top;

  e.target.style.position = 'absolute';
  e.target.style.zIndex = 1000;
  section.append(e.target);

  moveAt(e.pageX, e.pageY);

  function moveAt(pageX, pageY) {
    e.target.style.left = pageX - shiftX + 'px';
    e.target.style.top = pageY - shiftY + 'px';
  }


  function onMouseMove(event) {

    moveAt(event.pageX, event.pageY);

    e.target.hidden = true;
    let elemBelow = document.elementFromPoint(event.clientX, event.clientY);
    e.target.hidden = false;

    if (!elemBelow) return;

    let droppableBelow = elemBelow.closest('.droppable');
    if (currentDroppable != droppableBelow) {
      if (currentDroppable) {
        leaveDroppable(currentDroppable);

      }
      currentDroppable = droppableBelow;
      if (currentDroppable) {
        enterDroppable(currentDroppable);
        appendSideElement(e.target, droppableBelow);


      }
    }
  }

  document.addEventListener('mousemove', onMouseMove);

  e.target.onmouseup = function () {
    document.removeEventListener('mousemove', onMouseMove);
    e.target.onmouseup = null;
  };

};

function enterDroppable(elem) {
  elem.style.borderColor = 'blue';
}

function appendSideElement(elem, target) {
  const temp = elem;
  temp.style = "";
  temp.style.transition = 'transition: all 3s linear;';
  temp.className = "mini";
  elem.remove();
  target.append(temp);
}

function appendMainElement(elem) {
  elem.className = "mini";
  side.append(elem);

}

function leaveDroppable(elem) {
  elem.style.background = '';
}

con.ondragstart = function () {
  return false;
};

con.addEventListener('mousedown', moveContainer);

