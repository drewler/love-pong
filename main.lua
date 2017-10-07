love.window.setTitle("love-pong")

width = love.graphics.getWidth()
height = love.graphics.getHeight()

player1 = {
  score = 0,
  x = 80,
  y = 0,
  width = 20,
  height = 100,
  speed = 2
}

player2 = {
  score = 0,
  x = width - 100,
  y = 0,
  width = 20,
  height = 100,
  speed = 2
}

ball = {
  speed = 2,
  size = 20,
  x = 0,
  y = 0,
  dir = {x = 0, y = 0}
}

-- Collision detection function;
-- Returns true if two boxes overlap, false if they don't;
-- x1,y1 are the top-left coords of the first box, while w1,h1 are its width and height;
-- x2,y2,w2 & h2 are the same, but for the second box.
function CheckCollision(x1,y1,w1,h1, x2,y2,w2,h2)
  return x1 < x2+w2 and
         x2 < x1+w1 and
         y1 < y2+h2 and
         y2 < y1+h1
end

function draw_ball()
  love.graphics.rectangle("fill", ball.x, ball.y, ball.size, ball.size)
end

function update_ball()
  -- Update position
  ball.x = ball.x + ball.dir.x * ball.speed
  ball.y = ball.y + ball.dir.y * ball.speed
  -- Collision check
  if ball.y < 0 or ball.y + ball.size > height then
    ball.dir.y = -ball.dir.y
  end
  if CheckCollision(ball.x, ball.y, ball.size, ball.size, player2.x, player2.y, player2.width, player2.height) or
     CheckCollision(ball.x, ball.y, ball.size, ball.size, player1.x, player1.y, player1.width, player1.height) then
    ball.dir.x = -ball.dir.x
  end
  -- Goal check
  if ball.x < 0 then
    player2.score = player2.score + 1
    reposition_ball()
  end
  if ball.x > width then
    player1.score = player1.score + 1
    reposition_ball()
  end

end

function draw_player(player)
  love.graphics.rectangle("fill", player.x, player.y, player.width, player.height)
end

function reposition_ball()
  ball.x = width/2
  ball.y = 0
  ball.dir.x = love.math.random(-1,1)
  ball.dir.y = love.math.random(-1,1)
end

function draw_middle()
  for i=0,11 do
    love.graphics.rectangle("fill",width/2,70*i,15,40)
  end
end

function love.load()
  reposition_ball()
end

function love.draw()
  draw_ball()
  draw_player(player1)
  draw_player(player2)
  draw_middle()
end

function love.update()
  update_ball()
  if love.keyboard.isDown("up") then
    if player2.y > 0 then
      player2.y = player2.y - 1 * player2.speed
    end
    if player1.y > 0 then
      player1.y = player1.y - 1 * player1.speed
    end
  end
  if love.keyboard.isDown("down") then
    if player2.y + player2.height < height then
      player2.y = player2.y + 1 * player2.speed
    end
    if player1.y + player2.height < height then
      player1.y = player1.y + 1 * player1.speed
    end
  end
end
